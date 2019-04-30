From: hare@suse.de (Hannes Reinecke)
Date: Tue, 30 Apr 2019 07:43:31 +0200
Subject: [PATCH nvme-cli rfc] fabrics: support default connect/discover
 args
In-Reply-To: <20190429225338.6866-1-sagi@grimberg.me>
References: <20190429225338.6866-1-sagi@grimberg.me>
Message-ID: <493df3a7-6d25-9fd1-57ff-addbf37fcf22@suse.de>

On 4/30/19 12:53 AM, Sagi Grimberg wrote:
> Introduce /etc/nvme/defargs.conf where we allow the user to
> specify connect/discover parameters once and not for every
> controller. The cli will always ingest the content of this
> file before parsing cmdline args such that the user can
> override them.
> 
> The format is simply writing the arguments into the file as
> if they were appended to the execution command.
> 
> Also, properly install this file with some minimal documentation.
> 
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---
> This was raised before in the past that we don't have some place
> to store default connect args.
> 
> For example, when handling automatic discovery change log events
> this can be a way for the user to set global default arguments.
> 
> Feedback is welcome.
> 
>   Makefile            |  3 +++
>   etc/defargs.conf.in |  5 ++++
>   fabrics.c           | 63 +++++++++++++++++++++++++++++++++++++++++++++
>   nvme.spec.in        |  1 +
>   4 files changed, 72 insertions(+)
>   create mode 100644 etc/defargs.conf.in
> 

I do like the idea, but not necessarily the naming.
Can't we just call it 'default.conf' ?

What about precedence?
I would have expected that we should have

defargs.conf
discovery.conf
<cmdline>

Is that the case?
And shouldn't we document that somewhere?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N?rnberg)
