From: maxg@mellanox.com (Max Gurtovoy)
Date: Mon, 6 Nov 2017 11:40:27 +0200
Subject: [PATCH v2 1/1] nvme-rdma: Introduce nvme_rdma_destroy_qp
In-Reply-To: <88037f7c-0c24-c911-b605-9136d3009277@grimberg.me>
References: <1509804987-656-1-git-send-email-maxg@mellanox.com>
 <99ae0d5e-5ccf-a4f2-4e1c-d6e1f0e10016@grimberg.me>
 <d1bf1913-115c-fb07-2b4e-1d5322872f2b@mellanox.com>
 <88037f7c-0c24-c911-b605-9136d3009277@grimberg.me>
Message-ID: <afa1c1cd-fd0d-aa1d-4ae7-3d760d5f7a67@mellanox.com>



On 11/6/2017 11:31 AM, Sagi Grimberg wrote:
>> Do you prefer to point to freed memory ? I can resend it if needed.
> 
> Setting it to NULL suggest that we somehow rely on it, I'd prefer not
> to do it. Personally I don't think we really need the wrapper function
> until we actually need to compound operations when removing an rdma
> qp...

Ok, I'll send a fix to the error flow (this was my main goal).
