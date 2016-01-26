From: m@bjorling.me (=?UTF-8?Q?Matias_Bj=c3=b8rling?=)
Date: Tue, 26 Jan 2016 10:56:57 +0100
Subject: [patch] nvme: lightnvm: buffer overflow in nvme_nvm_identity()
In-Reply-To: <20160126092734.GE15717@mwanda>
References: <20160126092734.GE15717@mwanda>
Message-ID: <56A742E9.3040108@bjorling.me>

On 01/26/2016 10:27 AM, Dan Carpenter wrote:
> nvme_nvm_id->ppaf is 4 bytes larger than nvm_id->ppaf.  We're using the
> larger size struct for the sizeof() so we end up corrupting the
> first four bytes of nvm_id->groups[].  It doesn't look like we actually
> want to copy those last bytes anyway.
> 

Thanks, Dan. You are right. The four bytes are overwritten afterwards
and hid the issue.
