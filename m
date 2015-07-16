From: keith.busch@intel.com (Keith Busch)
Date: Thu, 16 Jul 2015 16:47:12 +0000 (UTC)
Subject: [PATCH 1/3] block: copy multi iovec user mappings if
 QUEUE_FLAG_SG_GAPS is set
In-Reply-To: <1436966356-8979-2-git-send-email-sagig@mellanox.com>
References: <1436966356-8979-1-git-send-email-sagig@mellanox.com>
 <1436966356-8979-2-git-send-email-sagig@mellanox.com>
Message-ID: <alpine.LNX.2.00.1507161633270.15930@localhost.lm.intel.com>

On Wed, 15 Jul 2015, Sagi Grimberg wrote:
> For drivers that don't support gaps in the SG lists handed to them we must
> not create bios from multiple iovecs as they can be (and usually are)
> discontiguous.  This doesn't matter for any current user, but will help
> to allow iSER which can't handle gaps to use the QUEUE_FLAG_SG_GAPS flag
> instead of using driver-local bounce buffering.

Maybe SG_GAPS is a bit of a misnomer. There are cases we can directly
map a user iov with multiple discontiguous vectors. At least for NVMe
it'd work if each iov's base and length are on page boundaries, we don't
need to do the indirect copy.

Like with this user example:
---
 	int fd = open("/dev/nvme0n1", O_RDONLY | O_DIRECT);
 	struct iovec iov[2];
  	unsigned char *buffer;

  	posix_memalign((void **)&buffer, 0x4000, 0x1000);

  	iov[0].iov_base = &buffer[0];
  	iov[1].iov_base = &buffer[0x2000];
  	iov[0].iov_len = 0x1000;
  	iov[1].iov_len = 0x1000;

 	readv(fd, iov, 2);
--
