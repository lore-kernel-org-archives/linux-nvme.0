From: jianchao.w.wang@oracle.com (jianchao.wang)
Date: Wed, 16 May 2018 11:03:09 +0800
Subject: [PATCH V5 0/9] nvme: pci: fix & improve timeout handling
In-Reply-To: <20180515125640.GC13679@ming.t460p>
References: <20180511122933.27155-1-ming.lei@redhat.com>
 <776f21e1-dc19-1b77-9ba4-44f0b8366625@oracle.com>
 <20180514093850.GA807@ming.t460p>
 <008cb38d-aa91-6ab7-64d9-417d6c53a1eb@oracle.com>
 <20180514122211.GB807@ming.t460p> <20180515003332.GB21743@ming.t460p>
 <d97b375f-9b47-6b95-bd5b-8166dae93676@oracle.com>
 <20180515125640.GC13679@ming.t460p>
Message-ID: <d54bd139-888c-c1dd-ae54-8959a31b404a@oracle.com>

Hi Ming

On 05/15/2018 08:56 PM, Ming Lei wrote:
> Looks a nice fix on nvme_create_queue(), but seems the change on 
> adapter_alloc_cq() is missed in above patch.
> 
> Could you prepare a formal one so that I may integrate it to V6?

Please refer to

Thanks
Jianchao
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-nvme-pci-set-nvmeq-cq_vector-after-alloc-cq-sq.patch
Type: text/x-patch
Size: 3091 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20180516/d4449ec7/attachment.bin>
