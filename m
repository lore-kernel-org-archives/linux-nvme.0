From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 21 Mar 2017 18:36:42 +0200
Subject: [GIT PULL] nvme patches for kernel 4.11 rc4
In-Reply-To: <1490114015-17672-1-git-send-email-sagi@grimberg.me>
References: <1490114015-17672-1-git-send-email-sagi@grimberg.me>
Message-ID: <c540d5b9-6811-f60f-b3e2-794ebbfb5783@grimberg.me>


> Hey Jens,
>
> This consists of some fixes for issues reported lately:
> - loop and rdma host driver cpu hotplug fixes
> - fix loop use-after-free
> - nvmet percpu_ref confirmation fix to fail ongoing requests
> - nvmet-rdma fix a non-initialized commands deref
>
> please pull from:
>
>   git://git.infradead.org/nvme.git nvme-4.11-rc

This is based off your for-linus branch, hope its ok...
