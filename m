From: osmithde@cisco.com (Oliver Smith-Denny)
Date: Tue, 12 Mar 2019 12:26:06 -0700
Subject: [PATCH 2/2] nvmet-tcp: implement C2HData SUCCESS optimization
In-Reply-To: <20190308234121.1347-3-sagi@grimberg.me>
References: <20190308234121.1347-1-sagi@grimberg.me>
 <20190308234121.1347-3-sagi@grimberg.me>
Message-ID: <0786e001-576b-6021-94b2-6c75f53550cd@cisco.com>

On 03/08/2019 03:41 PM, Sagi Grimberg wrote:
> TP 8000 says that the use of the SUCCESS flag depends on weather the
> controller support disabling sq_head pointer updates. Given that we
> support it by default, makes sense that we go the extra mile to actually
> use the SUCCESS flag.
> 
> When we create the C2HData PDU header, we check if sqhd_disabled is set
> on our queue, if so, we set the SUCCESS flag in the PDU header and
> skip sending a completion response capsule.
> 
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>

Target looks good, too.

Tested-and-Reviewed-by: Oliver Smith-Denny
