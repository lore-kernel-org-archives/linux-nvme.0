From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 9 Nov 2017 18:41:24 +0200
Subject: [PATCH] nvmet: better data length validation
In-Reply-To: <20171109132958.1816-1-hch@lst.de>
References: <20171109132958.1816-1-hch@lst.de>
Message-ID: <5effa992-70a1-72f5-4cca-86fae9cb6bd5@grimberg.me>


> Currently the NVMe target stores the expexted data length in req->data_len
> and uses that for data transfer decisions, but that does not take the
> actual transfer length in the SGLs into account.  So this adds a new
> transfer_len field, into which the transport drivers store the actual
> transfer length.  We then check the two match before actually executing
> the command.
> 
> The FC transport driver already had such a field, which is removed in
> favour of the common one.

That will also be useful when we will have DIF support ;)

Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
