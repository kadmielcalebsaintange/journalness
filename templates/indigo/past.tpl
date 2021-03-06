{include file="$theme/header.tpl"}
{include file="$theme/navigation.tpl"}
{section name=viewingentry show=$show_viewing_entry}
	{if $id}
		<div class="centered">
		<table class="entry_table" style="width:80%">
		  <tr>
		    <td class="entry_title"><br/>
			<strong>{$title}</strong>
		    </td>
		    {if $uid == $session_uid || $session_useraccess == "2"}
		      <td align="right" class="entry_title"><br/>
			<form style="margin-bottom:0;" action="modify.php" method="post" enctype="multipart/form-data">
			  <p><a href="modify.php?mode=edit&amp;id={$id}"><img src="templates/{$theme}/images/edit_post.gif" alt="Edit" /></a>
			  <a href="modify.php?mode=delete&amp;id={$id}"><img src="templates/{$theme}/images/delete_post.gif" alt="Delete" /></a></p>
		      </form>
			</td>
		    {/if}
		  </tr>
		  <tr>
		    <td colspan="2" class="entry">
			{$entry_text}
			{if $entry.modify_date}
			  <div class="modify_date">{$L_EDITED_ON} {$entry.modify_date}</div>
			{/if}
		    </td>
		  </tr>
		  <tr>
		  <td colspan="2" class="entry_footer">
	 	  {$L_POSTED_ON} {$date} {$L_POSTED_BY} <a href="profile.php?mode=viewprofile&amp;user={$uid}"><strong>{$user}</strong></a> {section name=entrycatloop loop=$entry.categories}{if $smarty.section.entrycatloop.first}{$L_POSTED_IN} {/if}<a href="past.php?catid={$entry.categories[entrycatloop].id}">{$entry.categories[entrycatloop].name}</a>{if !$smarty.section.entrycatloop.last}, {/if}{/section} {if $journalnessConfig_allow_comments}| <a href="#comments">{$L_COMMENTS} ({$numcomments})</a>{/if}
	          {if $session_useraccess == "2"}
		    | <strong>IP:</strong> {$ip_address}
	          {/if}
	          </td>
	   </tr>
	   <tr>
	     <td>
		{if $journalnessConfig_next_prev}
		<div class="centered">
		<table border="0" cellpadding="20" style="width:80%">
	  	  <tr>
	    	    <td>
			<div style="text-align:right">
		  	{if $prev}
		    	  <h4><a href="past.php?id={$prev}">&laquo; {$prevtitle}</a></h4>
		  	{else}
		    	  <h4>&laquo; {$L_PREVIOUS_POST}</h4>
		  	{/if}
			</div>
	    	    </td>
	    	    <td>
			<div style="text-align:left">
		  	{if $next}
		    	  <h4><a href="past.php?id={$next}">{$nexttitle} &raquo;</a></h4>
		  	{else}
		    	  <h4>{$L_NEXT_POST} &raquo;</h4>
		  	{/if}
			</div>
	    	    </td>
	  	  </tr>
		</table>
		</div>
		{/if}
		<h2><a name="comments" style="text-decoration:none;">{$L_COMMENTS}</a></h2>
		{if !$journalnessConfig_allow_comments}
			<p style="padding-left:25px;">{$L_COMMENTS_DISABLED}</p>
		{elseif !$comments}
			<p style="padding-left:25px;">{$L_NO_COMMENTS}</p>
		{else}
			{section name=commentloop loop=$comments show=$show_comment_loop}
		<form style="margin-bottom:0;" action="modify.php" method="post" enctype="multipart/form-data">
		<table border="0" cellpadding="0" cellspacing="0" style="width:100%">
		  <tr>
		    <td class="comment_title">
			<a name="c{$comments[commentloop].id}" style="text-decoration:none; font-weight:bold;">{$comments[commentloop].title}</a>
			{if $session_useraccess == "2"}
                    </td>
                    <td align="right" class="comment_title">
                      <a href="modify.php?mode=edit_comment&amp;id={$comments[commentloop].id}&amp;entryid={$comments[commentloop].entryid}"><img src="templates/{$theme}/images/edit_post.gif" alt="Edit" /></a>
			    <a href="modify.php?mode=delete_comment&amp;id={$comments[commentloop].id}&amp;entryid={$comments[commentloop].entryid}"><img src="templates/{$theme}/images/delete_post.gif" alt="Delete" /></a>
			  </td>
		  </tr>
                  <tr>
                    <td colspan="2">
 			{/if}
			<div class="comment">{$comments[commentloop].comment_text}</div>
                    </td>
                  </tr>
                  <tr> 
		    <td colspan="2" class="commentfooter">
                       <p>{$L_POSTED_ON} {$comments[commentloop].date} {$L_POSTED_BY} <strong>{if $comments[commentloop].uid}<a href="profile.php?mode=viewprofile&user={$comments[commentloop].uid}">{/if}{$comments[commentloop].username}{if $comments[commentloop].uid}</a>{/if}</strong>
                       {if $session_useraccess == "2"}
                         | <strong>IP:</strong> {$comments[commentloop].ip_address}
                       {/if}
                       </p>
		    </td>
		  </tr>
		</table>
		</form><br/>
			{/section}
		{/if}
		{section name=commentform show=$show_comment_form}
		  <table border="0" cellpadding="0" cellspacing="0" style="width:100%">
		    <tr>
		     <td align="left">
			 <br/><br/><h2><a name="addcomment" style="text-decoration:none;">{$L_ADD_COMMENT}</a></h2>
			 {if $num_errors > 0}<p style="color:red;">{$num_errors} error(s) found<br/><br/></p>{/if}
			 <form action="past.php?id={$id}" method="post" enctype="multipart/form-data">
			 <h5>{$L_TITLE} {$title_error}</h5>
			 <p><input class="textinput" name="title" maxlength="50" size="35" value="{$title_value}"/><br/></p>
			 <h5>{$L_COMMENT} {$comment_text_error}</h5>
			 <p><textarea class="textinput" name="comment_text" cols="50" rows="15">{$comment_text_value}</textarea></p>
			 <p><input class="textinput" type="hidden" value="{$id}" name="entryid"/></p>
			 <p><input class="button" type="submit" value="{$L_POST_COMMENT}" name="submit"/></p>
			 </form>
		     </td>
		  </tr>
		  </table>
		{/section}
	{else}
		<table style="width:100%">
		  <tr>
		    <td style="text-align:center;">
			<p>{$L_INVALID_ID}</p>
		    </td>
		  </tr>
		</table>
	{/if}
{/section}
{section name=titles show=$show_titles}
  <div class="centered">
    <table border="0" cellpadding="5">
      <tr>
	  <td colspan="3" style="text-align:center">
	    <h4>{if $show_day_entries}{$L_ENTRIES_FOR}{elseif $show_cat_entries}{$L_ENTRIES_FOR_CATEGORY}{else}{$L_ALL_ENTRIES}{/if}</h4><br/>
	  </td>
	</tr>
        <tr>
          <td>
            <table class="default_table" border="0" cellpadding="3" cellspacing="0">
	<tr class="default_tableheader">
	  <td>
	    <div class="centered">
		<strong>
		  {$L_DATE_ENTERED}
		</strong>
	    </div>
	  </td>
	  <td>
	    <div class="centered">
		<strong>
		  {$L_PAST_TITLE}
		</strong>
	    </div>
	  </td>
	  <td>
	    <div class="centered">
		<strong>
		  {$L_PAST_POSTED_BY}
	      </strong>
	    </div>
	  </td>
	  <td>
	    <div class="centered">
		<strong>
		  {$L_COMMENTS}
	      </strong>
	    </div>
	  </td>
	  <td>
	    <div class="centered">
		<strong>
		  {$L_VIEWS}
	      </strong>
	    </div>
	  </td>
	</tr>
{/section}
{section name=entrylist loop=$entries show=$show_entry_list}
 	 <tr style="background-color:{cycle name=firstrow values="#BBBBBB,#E9E9E9"};">
 	   <td>
	<div class="centered">
	    <p>{$entries[entrylist].date}</p>
	</div>
    </td>
    <td align="center">
	<div class="titleoverflow">
	  <p><a href="past.php?id={$entries[entrylist].id}">{$entries[entrylist].title}</a></p>
	</div>
    </td>
    <td>
	<div class="centered">
	    <p><a href="profile.php?mode=viewprofile&amp;user={$entries[entrylist].uid}">{$entries[entrylist].username}</a></p>
	</div>
    </td>
    <td>
	<div class="centered">
	  <p><a href="past.php?id={$entries[entrylist].id}#comments">{$entries[entrylist].numcomments}</a></p>
	</div>
    </td>
    <td colspan="2">
	<div class="centered">
	  <p>{$entries[entrylist].views}</p>
	</div>
    </td>
	</tr>
	<tr style="background-color:{cycle name=secondrow values="#BBBBBB,#E9E9E9"};">
	  <td colspan="5" style="padding-bottom: 5px;">
		<span style="margin: 2px; font-size:10px;">{section name=catloop loop=$entries[entrylist].categories}{if $smarty.section.catloop.first}<em>{$L_CATEGORIES}: </em>{/if}<a href="past.php?catid={$entries[entrylist].categories[catloop].id}">{$entries[entrylist].categories[catloop].name}</a>{if !$smarty.section.catloop.last}, {/if}{/section}</span>
	  </td>
	</tr>
{/section}
	</table>
	</div>
 	<div class="centered">
	<table border="0" cellpadding="5">
	  <tr>
	    <td style="text-align:center;">
		{$pageLinks}<br/>
		{$pageCounter}
	 	</td>
	    </tr>
	  </table>
	</div>
	</td>
    </tr>
{include file="$theme/footer.tpl"}