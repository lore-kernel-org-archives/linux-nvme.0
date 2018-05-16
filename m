From: jianchao.w.wang@oracle.com (jianchao.wang)
Date: Wed, 16 May 2018 10:15:32 +0800
Subject: [PATCH V5 0/9] nvme: pci: fix & improve timeout handling
In-Reply-To: <20180516020903.GC17412@ming.t460p>
References: <20180511122933.27155-1-ming.lei@redhat.com>
 <776f21e1-dc19-1b77-9ba4-44f0b8366625@oracle.com>
 <20180514093850.GA807@ming.t460p>
 <008cb38d-aa91-6ab7-64d9-417d6c53a1eb@oracle.com>
 <20180514122211.GB807@ming.t460p> <20180515003332.GB21743@ming.t460p>
 <d97b375f-9b47-6b95-bd5b-8166dae93676@oracle.com>
 <20180516020420.GB17412@ming.t460p> <20180516020903.GC17412@ming.t460p>
Message-ID: <c9a621e1-f114-321f-6a7d-b04a2c987582@oracle.com>

Hi ming

On 05/16/2018 10:09 AM, Ming Lei wrote:
> So could you check if only the patch("unquiesce admin queue after shutdown
> controller") can fix your IO hang issue?

I indeed tested this before fix the warning.
It could fix the io hung issue. :)

Thanks
Jianchao
