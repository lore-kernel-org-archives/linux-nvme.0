From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 26 Sep 2016 07:42:27 -0700
Subject: [PATCH 3/3] nvme-fabrics: Move controller id to opts struct
In-Reply-To: <57e9321a.e6Pgooc71MbSI4hg%james.smart@broadcom.com>
References: <57e9321a.e6Pgooc71MbSI4hg%james.smart@broadcom.com>
Message-ID: <20160926144227.GA9792@infradead.org>

On Mon, Sep 26, 2016@07:35:06AM -0700, James Smart wrote:
> The FC transport needs the controller ID for transport connect which occur
> prior to the fabric connect command.  Currently, it's hardcoded in the
> fabrics code for the fabric connect cmd formatting routine.
> 
> Reworked to have controller id set in the opts structure. Adds support
> for controller id to be specified as an option.

Having the controller ID as the option really doesn't make sense, we'll
take what the target side gives us during the admin connect.
