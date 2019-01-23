From: javier@javigon.com (=?utf-8?Q?Javier_Gonz=C3=A1lez?=)
Date: Wed, 23 Jan 2019 19:35:39 +0100
Subject: [PATCH v2 0/4] Write-hint for FS journal
In-Reply-To: <1547047861-7271-1-git-send-email-joshi.k@samsung.com>
References: <CGME20190109153328epcas2p4643cbdc7a2182b47893a2bcaa0778e17@epcas2p4.samsung.com>
 <1547047861-7271-1-git-send-email-joshi.k@samsung.com>
Message-ID: <B766FDC6-0B26-4D25-95B6-26807D3E2C79@javigon.com>


> On 9 Jan 2019,@16.30, Kanchan Joshi <joshi.k@samsung.com> wrote:
> 
> Towards supporing write-hints/streams for filesystem journal.
> 
> Here is the v1 patch for background -
> https://marc.info/?l=linux-fsdevel&m=154444637519020&w=2
> 
> Changes since v1:
> - introduce four more hints for in-kernel use, as recommended by Dave chinner
>  & Jens axboe. This isolates kernel-mode hints from user-mode ones.
> - remove mount-option to specify write-hint, as recommended by Jan kara &
>  Dave chinner. Rather, FS always sets write-hint for journal. This gets ignored
>  if device does not support stream.
> - Removed code-redundancy for write_dirty_buffer (Jan kara's review comment)
> 
> 
> Kanchan Joshi (4):
>  block: Increase count of supported write-hints
>  fs: introduce four macros for in-kernel hints
>  fs: introduce APIs to enable sending write-hint with buffer-head
>  fs/ext4,jbd2: add support for passing write-hint with journal.
> 
> fs/buffer.c                 | 18 ++++++++++++++++--
> fs/ext4/super.c             |  2 ++
> fs/jbd2/commit.c            | 11 +++++++----
> fs/jbd2/journal.c           |  3 ++-
> fs/jbd2/revoke.c            |  3 ++-
> include/linux/blkdev.h      |  5 ++++-
> include/linux/buffer_head.h |  3 +++
> include/linux/fs.h          |  5 +++++
> include/linux/jbd2.h        |  8 ++++++++
> 9 files changed, 49 insertions(+), 9 deletions(-)
> 
> --
> 2.7.4

Worth sharing the paper where you describe the design and the numbers
you collected [1]. Also, addressing Dave's comment on stream support, it
points to a Samsung drive supporting streams (PM963). In this context,
you should verify in V3 that we are at least passing xfstests and
blktests with these changes.

[1] https://www.usenix.org/system/files/conference/fast18/fast18-rho.pdf

Javier
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: Message signed with OpenPGP
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20190123/84bcc19a/attachment-0001.sig>
