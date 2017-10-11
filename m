From: james.smart@broadcom.com (James Smart)
Date: Wed, 11 Oct 2017 08:07:36 -0700
Subject: [PATCH v2] nvme_fc: retry initial controller connections 3 times
In-Reply-To: <d80601a9-bead-2b21-fdaf-fea01fbdbafe@grimberg.me>
References: <20171009233922.7216-1-jsmart2021@gmail.com>
 <d80601a9-bead-2b21-fdaf-fea01fbdbafe@grimberg.me>
Message-ID: <542d4c8e-54fc-0fd7-c29d-5cf1ed2934fa@broadcom.com>

On 10/11/2017 4:09 AM, Sagi Grimberg wrote:
> Its not directly related to this patch, but the error handling here
> seems non trivial, why isn't this going to the normal out_* error
> targets below in the function?

Because, while debugging the original flow which did teardown in the 
calling sequence like rdma, had a lot of concurrency issues and didn't 
fit well with a more generic create_association/delete_association back 
end. The issue is how many things are real hw contexts in FC that have 
to be flushed with the lldd before delete can really occur.? Those paths 
are all solved already for the LIVE->DELETING flows using ref-counting.? 
So, I perform the calling-sequence teardown until the nvme controller is 
init'd, at which point I defer to the normal refcounting delete flows. 
There's a comment that highlights that.

-- james
