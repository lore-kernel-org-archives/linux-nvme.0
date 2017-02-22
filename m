From: axboe@kernel.dk (Jens Axboe)
Date: Wed, 22 Feb 2017 13:28:20 -0700
Subject: [GIT PULL] nvme patches for 4.11
In-Reply-To: <1487791916-25599-1-git-send-email-sagi@grimberg.me>
References: <1487791916-25599-1-git-send-email-sagi@grimberg.me>
Message-ID: <6e829c66-8ebf-9aff-a14f-8031ba891876@kernel.dk>

On 02/22/2017 12:31 PM, Sagi Grimberg wrote:
> Hey Jens,
> 
> This pull-request includes:
> - autonomous power state transitions from Andy
> - nvme-rdma support for connecting via configurable source ip
> - nvmet-rdma cleanups from Max
> - nvme-fc cleanups from James
> - quirk fixup for apple from Daniel
> - various nvme-pci fixes from Keith
> - expose nvme controller state via sysfs
> - identify CNS fixup from Parav
> - enforce fabrics implement ->create_ctrl callout from Johannes
> - nvme-rdma fix goto tag from Christophe
> - spelling fixup from Colin
> 
> Please pull from:
> 
>   git://git.infradead.org/nvme.git nvme-4.11

Pulled, but this really should have been sent in at least a
week earlier...

-- 
Jens Axboe
