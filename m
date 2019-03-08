From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri, 8 Mar 2019 15:43:27 -0800
Subject: [PATCH 1/2] nvme-tcp: support C2HData with SUCCESS flag
In-Reply-To: <20190308234121.1347-2-sagi@grimberg.me>
References: <20190308234121.1347-1-sagi@grimberg.me>
 <20190308234121.1347-2-sagi@grimberg.me>
Message-ID: <b0dcff3b-2e6b-cb62-eb74-bfad708f09d0@grimberg.me>


> A C2HData PDU with the SUCCESS flag set indicates that the I/O was
> completed by the controller successfully and means that a subsequent
> completion response capsule PDU will be ommitted.
> 
> If we see this flag, fisrt we check that LAST_PDU flag is set as well,
> and then we complete the request when the data transfer (and data digest
> verification if its on) is done.
> 
> While we're at it, reuse a bit of code with nvme_fail_request.
> 

rrr...

This should also have:

Reported-by: Steve Blightman <steve.blightman at oracle.com>

> Suggested-by: Oliver Smith-Denny <osmithde at cisco.com>
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---
