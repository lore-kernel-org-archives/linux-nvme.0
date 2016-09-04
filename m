From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 4 Sep 2016 10:01:37 +0300
Subject: [PATCH v5 0/6] nvme-rdma device removal fixes
In-Reply-To: <cover.1472833420.git.swise@opengridcomputing.com>
References: <cover.1472833420.git.swise@opengridcomputing.com>
Message-ID: <89eb2382-9a2f-48d1-c9fd-0c018e07cd9f@grimberg.me>


> This series addresses several problems when shutting down a nvme-rdma
> host when its controllers are attempting to reconnect to a target that
> is no longer reachable.
>
> To tickle these bugs:
>
> 1) attach over iw_cxgb4 to 10 devices on a target.
> 2) 'ifconfig down' the target's interface
> 3) wait for keep-alive to fire and begin reconnecting (~15-20 seconds)
> 4) do one of these on the host:
>    - rmmod iw_cxgb4
>    - reboot
>    - reboot -f
>
> Doug/Sagi, the first 2 iw_cxgb4 patches are included here because they're
> needed for the testing.  While I've also submitted them to linux-rdma,
> perhaps Sagi can merge them in nvmf-4.8-rc?  If that is acceptable
> with everyone.

Fine with me,

Queued for the next round of rc fixes.

Thanks Steve!
