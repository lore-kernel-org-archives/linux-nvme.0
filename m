From: axboe@kernel.dk (Jens Axboe)
Date: Thu, 27 Apr 2017 11:36:00 -0600
Subject: [GIT PULL] nvme updates for 4.12
In-Reply-To: <20170427171939.tnlpqb5qmazns334@infradead.org>
References: <20170427171939.tnlpqb5qmazns334@infradead.org>
Message-ID: <0d1264ff-a8b6-7df5-6d8a-572525275e0c@kernel.dk>

On 04/27/2017 11:19 AM, Christoph Hellwig wrote:
> A couple more updates for 4.12.  The biggest pile is fc and lpfc updates
> from James, but there are various small fixes and cleanups as well.
> 
> The following changes since commit a44f53faf4674d84cba79f7ee574584e18ab8744:
> 
>   lightnvm: pblk: fix erase counters on error fail (2017-04-23 16:57:52 -0600)
> 
> are available in the git repository at:
> 
>   git://git.infradead.org/nvme.git nvme-4.12

Pulled, but it threw two merge issues that I fixed up. Please double
check them.

Additionally, if CONFIG_NVME_TARGET_FC isn't enabled,
lpfc_nvmet_rcv_unsol_abort() threw a warning on missing a return
statement. I caught that one, don't know if there are others...

It's queued up in the for-4.12/post-merge branch because of these
conflicts with master.

-- 
Jens Axboe
