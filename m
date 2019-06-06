From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Fri, 7 Jun 2019 04:24:20 +0900
Subject: nvme: build failure report for nvme_sync_queues()
In-Reply-To: <20190606184620.GA1676@minwooim-desktop>
References: <20190606184620.GA1676@minwooim-desktop>
Message-ID: <20190606192420.GA17774@minwooim-desktop>

On 19-06-07 03:46:20, Minwoo Im wrote:
> Hi all,
> 
> I'd have to report a build failure due to the following commit:
> Commit e7ae6d1e7c5f ("nvme-pci: Use host managed power state for suspend")
> 
> Message:
> drivers/nvme/host/pci.c:2876:2: error: implicit declaration of function ?nvme_sync_queues?; did you mean ?nvme_stop_queues?? [-Werror=implicit-function-declaration]
>   nvme_sync_queues(ctrl);
>     ^~~~~~~~~~~~~~~~
> 
> Is the following patch applied to this branch ?
>   [PATCHv4 1/4] nvme: Sync request queues on reset:
>   http://lists.infradead.org/pipermail/linux-nvme/2018-July/019166.html
> 
> If I miss something here, please let mw know.
> 
> Thanks,

Sorry I forgot to mention the branch name: nvme-5.3
