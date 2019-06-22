From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Sat, 22 Jun 2019 09:40:10 +0900
Subject: [PATCH] nvme-fcloop: Fix inconsistent lock state warnings
In-Reply-To: <20190620200700.15659-1-jsmart2021@gmail.com>
References: <20190620200700.15659-1-jsmart2021@gmail.com>
Message-ID: <20190622004010.GD3139@minwooim-desktop>

On 19-06-20 13:07:00, James Smart wrote:
> With extra debug on, inconsistent lock state warnings are being
> called out as the tfcp_req->reqlock is being taken out without
> irq, while some calling sequences have the sequence in a softirq
> state.
> 
> Change the lock taking/release to raise/drop irq.
> 
> Signed-off-by: James Smart <jsmart2021 at gmail.com>

It looks good to me:

Reviewed-by: Minwoo Im <minwoo.im.dev at gmail.com>
