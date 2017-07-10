From: keith.busch@intel.com (Keith Busch)
Date: Mon, 10 Jul 2017 12:59:18 -0400
Subject: [PATCH v2] nvme-cli/list-ns: fix identifying active or allocated
 namespaces list
In-Reply-To: <1499673367-9740-1-git-send-email-guanjunxiong@huawei.com>
References: <1499673367-9740-1-git-send-email-guanjunxiong@huawei.com>
Message-ID: <20170710165917.GE14788@localhost.localdomain>

On Mon, Jul 10, 2017@03:56:07PM +0800, Guan Junxiong wrote:
> The logic of the CNS field of identify namespace list is wrong.
> For example, nvme list-ns /dev/nvme0 -n 0  should return active
> namespaces list starting with id 1 (including), but currently this
> script command returns INVALID_OPCODE if the target doesn't support 
> listing allocated namespaces or all the allocated attached namespaces
> id. So fix it by swaping the CNS flags of active and allocated list.

Thanks for the fix. Applied as-is, but I just want to point out that
the status code for the situation you're describing should have been
"Invalid Field in Command" rather than "Invalid Opcode".
