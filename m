From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Thu, 6 Jun 2019 19:21:08 +0000
Subject: nvme: build failure report for nvme_sync_queues()
References: <20190606184620.GA1676@minwooim-desktop>
Message-ID: <BYAPR04MB574973D3980B38C849CB6C0986170@BYAPR04MB5749.namprd04.prod.outlook.com>

I've the same problem.
On 06/06/2019 11:46 AM, Minwoo Im wrote:
> Hi all,
>
> I'd have to report a build failure due to the following commit:
> Commit e7ae6d1e7c5f ("nvme-pci: Use host managed power state for suspend")
>
> Message:
> drivers/nvme/host/pci.c:2876:2: error: implicit declaration of function ?nvme_sync_queues?; did you mean ?nvme_stop_queues?? [-Werror=implicit-function-declaration]
>    nvme_sync_queues(ctrl);
>      ^~~~~~~~~~~~~~~~
>
> Is the following patch applied to this branch ?
>    [PATCHv4 1/4] nvme: Sync request queues on reset:
>    http://lists.infradead.org/pipermail/linux-nvme/2018-July/019166.html
>
> If I miss something here, please let mw know.
>
> Thanks,
>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
>
