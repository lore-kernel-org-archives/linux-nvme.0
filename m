From: jack@suse.cz (Jan Kara)
Date: Thu, 24 Jan 2019 09:50:35 +0100
Subject: [PATCH 4/4] fs/ext4,jbd2: add support for passing write-hint
 with journal.
In-Reply-To: <1547047861-7271-5-git-send-email-joshi.k@samsung.com>
References: <1547047861-7271-1-git-send-email-joshi.k@samsung.com>
 <CGME20190109153342epcas2p3208f62a4dd876f8e1765b48f8aec2432@epcas2p3.samsung.com>
 <1547047861-7271-5-git-send-email-joshi.k@samsung.com>
Message-ID: <20190124085035.GC12184@quack2.suse.cz>

On Wed 09-01-19 21:01:01, Kanchan Joshi wrote:
> For NAND based SSDs, mixing of data with different life-time reduces
> efficiency of internal garbage-collection. During FS operations, series
> of journal updates will follow/precede series of data/meta updates, causing
> intermixing inside SSD. By passing a write-hint with journal, its write
> can be isolated from other data/meta writes, leading to endurance/performance
> benefit on SSD.
> 
> This patch introduces "j_writehint" member in JBD2 journal, using which
> Ext4 specifies write-hint (as SHORT) for journal.
> 
> Signed-off-by: Kanchan Joshi <joshi.k at samsung.com>

Thanks for the patch. It looks mostly good, just one nit below.

> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index d6c142d..3af4049 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -4289,6 +4289,8 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
>  
>  	set_task_ioprio(sbi->s_journal->j_task, journal_ioprio);
>  
> +	sbi->s_journal->j_writehint = KERN_WRITE_LIFE_SHORT;
> +
>  	sbi->s_journal->j_commit_callback = ext4_journal_commit_callback;

So I'd rather have defines like:

#define EXT4_WRITE_HINT_JOURNAL KERN_WRITE_HINT_MIN

like I suggested in another email and then later we could add stuff like

#define EXT4_WRITE_HINT_BITMAP	(KERN_WRITE_HINT_MIN + 1)

etc.

								Honza
-- 
Jan Kara <jack at suse.com>
SUSE Labs, CR
