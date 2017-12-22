From: snitzer@redhat.com (Mike Snitzer)
Date: Fri, 22 Dec 2017 11:41:13 -0500
Subject: nvmet_fc: correct broken add_port
In-Reply-To: <079257ac-fc03-d28e-3906-7a584b5bee4a@broadcom.com>
References: <20171221164335.12400-1-jsmart2021@gmail.com>
 <20171222072336.n6jr2ybr5gspxsrf@linux-x5ow.site>
 <079257ac-fc03-d28e-3906-7a584b5bee4a@broadcom.com>
Message-ID: <20171222164113.GA31385@redhat.com>

On Fri, Dec 22 2017 at 10:50am -0500,
James Smart <james.smart@broadcom.com> wrote:

> On 12/21/2017 11:23 PM, Johannes Thumshirn wrote:
> >But a Fixes: and/or Cc: <stable at vger.kernel.org> might have been a
> >good Idea as well.
> >
> 
> Fixes perhaps.? The patch that introduced the issue
> (a0b69cc8e5caff3cb6442dfa807f47b44e716aad) is only in nvme-4.16, so
> it doesn't quite apply.

Right, a Fixes: reference is useful even if the Cc: stable isn't
relevant.

This fixes the issue I reported -- where I needed to revert commit
a0b69cc8e5 ("nvmet-fc: cleanup nvmet add_port/remove_port") to allow
nvme connect to work with fcloop.

Christoph, please feel free to add:

Fixes: a0b69cc8e5 ("nvmet-fc: cleanup nvmet add_port/remove_port")
Tested-by: Mike Snitzer <snitzer at redhat.com>
