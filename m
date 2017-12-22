From: james.smart@broadcom.com (James Smart)
Date: Fri, 22 Dec 2017 07:50:03 -0800
Subject: [PATCH] nvmet_fc: correct broken add_port
In-Reply-To: <20171222072336.n6jr2ybr5gspxsrf@linux-x5ow.site>
References: <20171221164335.12400-1-jsmart2021@gmail.com>
 <20171222072336.n6jr2ybr5gspxsrf@linux-x5ow.site>
Message-ID: <079257ac-fc03-d28e-3906-7a584b5bee4a@broadcom.com>

On 12/21/2017 11:23 PM, Johannes Thumshirn wrote:
> But a Fixes: and/or Cc: <stable at vger.kernel.org> might have been a
> good Idea as well.
>

Fixes perhaps.? The patch that introduced the issue 
(a0b69cc8e5caff3cb6442dfa807f47b44e716aad) is only in nvme-4.16, so it 
doesn't quite apply.

-- james
