From: adilger@dilger.ca (Andreas Dilger)
Date: Sat, 30 Mar 2019 11:49:54 -0600
Subject: [PATCH v3 7/7] fs/ext4,jbd2: add support for passing write-hint
 with journal
In-Reply-To: <1553846032-4451-8-git-send-email-joshi.k@samsung.com>
References: <1553846032-4451-1-git-send-email-joshi.k@samsung.com>
 <CGME20190329075800epcas2p4731f10eabf7d70dc7096117d161b05a3@epcas2p4.samsung.com>
 <1553846032-4451-8-git-send-email-joshi.k@samsung.com>
Message-ID: <4B0B5E8B-3B30-4CF6-AA9D-D1294542D65D@dilger.ca>

On Mar 29, 2019,@1:53 AM, Kanchan Joshi <joshi.k@samsung.com> wrote:
> 
> For NAND based SSDs, mixing of data with different life-time reduces
> efficiency of internal garbage-collection. During FS operations, series
> of journal updates will follow/precede series of data/meta updates, causing
> intermixing inside SSD. By passing a write-hint with journal, its write
> can be isolated from other data/meta writes, leading to endurance/performance
> benefit on SSD.
> 
> This patch introduces "j_writehint" member in JBD2 journal, using which
> Ext4 specifies write-hint (as SHORT) for journal

The comment here says the "WRITE_LIFE_SHORT" hint is used for the journal,
but the code uses WRITE_LIFE_KERN_MIN.  However, it seems that "MIN" will
be mapped to "NONE" if it exceeds the number of streams available in the
underlying device.  It would be better to use "SHORT" if there are not
enough streams available.

It should call blk_queue_stream_limits() to see if there are extra stream
IDs available, and fall back to WRITE_LIFE_SHORT if not.

Cheers, Andreas

> Signed-off-by: Kanchan Joshi <joshi.k at samsung.com>
> ---
> fs/ext4/ext4_jbd2.h  |  1 +
> fs/ext4/super.c      |  2 ++
> fs/jbd2/commit.c     | 11 +++++++----
> fs/jbd2/journal.c    |  3 ++-
> fs/jbd2/revoke.c     |  3 ++-
> include/linux/jbd2.h |  8 ++++++++
> 6 files changed, 22 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/ext4/ext4_jbd2.h b/fs/ext4/ext4_jbd2.h
> index 15b6dd7..b589ca4 100644
> --- a/fs/ext4/ext4_jbd2.h
> +++ b/fs/ext4/ext4_jbd2.h
> @@ -16,6 +16,7 @@
> #include <linux/jbd2.h>
> #include "ext4.h"
> 
> +#define EXT4_JOURNAL_WRITE_HINT (WRITE_LIFE_KERN_MIN)
> #define EXT4_JOURNAL(inode)	(EXT4_SB((inode)->i_sb)->s_journal)
> 
> /* Define the number of blocks we need to account to a transaction to
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index fb12d3c..9c2c73e 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -4289,6 +4289,8 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
> 
> 	set_task_ioprio(sbi->s_journal->j_task, journal_ioprio);
> 
> +	sbi->s_journal->j_writehint = EXT4_JOURNAL_WRITE_HINT;
> +
> 	sbi->s_journal->j_commit_callback = ext4_journal_commit_callback;
> 
> no_journal:
> diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
> index 2eb55c3..6da4c28 100644
> --- a/fs/jbd2/commit.c
> +++ b/fs/jbd2/commit.c
> @@ -153,10 +153,12 @@ static int journal_submit_commit_record(journal_t *journal,
> 
> 	if (journal->j_flags & JBD2_BARRIER &&
> 	    !jbd2_has_feature_async_commit(journal))
> -		ret = submit_bh(REQ_OP_WRITE,
> -			REQ_SYNC | REQ_PREFLUSH | REQ_FUA, bh);
> +		ret = submit_bh_write_hint(REQ_OP_WRITE,
> +			REQ_SYNC | REQ_PREFLUSH | REQ_FUA, bh,
> +			journal->j_writehint);
> 	else
> -		ret = submit_bh(REQ_OP_WRITE, REQ_SYNC, bh);
> +		ret = submit_bh_write_hint(REQ_OP_WRITE, REQ_SYNC, bh,
> +			journal->j_writehint);
> 
> 	*cbh = bh;
> 	return ret;
> @@ -711,7 +713,8 @@ void jbd2_journal_commit_transaction(journal_t *journal)
> 				clear_buffer_dirty(bh);
> 				set_buffer_uptodate(bh);
> 				bh->b_end_io = journal_end_buffer_io_sync;
> -				submit_bh(REQ_OP_WRITE, REQ_SYNC, bh);
> +				submit_bh_write_hint(REQ_OP_WRITE, REQ_SYNC,
> +						bh, journal->j_writehint);
> 			}
> 			cond_resched();
> 			stats.run.rs_blocks_logged += bufs;
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index 8ef6b6d..804dc2c 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -1384,7 +1384,8 @@ static int jbd2_write_superblock(journal_t *journal, int write_flags)
> 	jbd2_superblock_csum_set(journal, sb);
> 	get_bh(bh);
> 	bh->b_end_io = end_buffer_write_sync;
> -	ret = submit_bh(REQ_OP_WRITE, write_flags, bh);
> +	ret = submit_bh_write_hint(REQ_OP_WRITE, write_flags, bh,
> +				journal->j_writehint);
> 	wait_on_buffer(bh);
> 	if (buffer_write_io_error(bh)) {
> 		clear_buffer_write_io_error(bh);
> diff --git a/fs/jbd2/revoke.c b/fs/jbd2/revoke.c
> index a1143e5..376b1d8 100644
> --- a/fs/jbd2/revoke.c
> +++ b/fs/jbd2/revoke.c
> @@ -642,7 +642,8 @@ static void flush_descriptor(journal_t *journal,
> 	set_buffer_jwrite(descriptor);
> 	BUFFER_TRACE(descriptor, "write");
> 	set_buffer_dirty(descriptor);
> -	write_dirty_buffer(descriptor, REQ_SYNC);
> +	write_dirty_buffer_with_hint(descriptor, REQ_SYNC,
> +				journal->j_writehint);
> }
> #endif
> 
> diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
> index 0f919d5..918f21e 100644
> --- a/include/linux/jbd2.h
> +++ b/include/linux/jbd2.h
> @@ -1139,6 +1139,14 @@ struct journal_s
> 	 */
> 	__u32 j_csum_seed;
> 
> +	/**
> +	 * @j_writehint:
> +	 *
> +	 * write-hint for journal (set by FS).
> +	 */
> +	enum rw_hint	j_writehint;
> +
> +
> #ifdef CONFIG_DEBUG_LOCK_ALLOC
> 	/**
> 	 * @j_trans_commit_map:
> --
> 2.7.4
> 


Cheers, Andreas





-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 873 bytes
Desc: Message signed with OpenPGP
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20190330/17d70eac/attachment.sig>
