From: keith.busch@intel.com (Keith Busch)
Date: Tue, 16 Aug 2016 23:45:08 +0000
Subject: [PATCH v3 RFC 2/2] nvme: improve performance for virtual NVMe
 devices
In-Reply-To: <1471380303.21107.38.camel@linux.intel.com>
References: <1460657059-21214-1-git-send-email-helen.koike@collabora.co.uk>
 <cover.1471308889.git.helen.koike@collabora.co.uk>
 <c738f3d3c14907a9074a40b1658461e008fbed9e.1471308889.git.helen.koike@collabora.co.uk>
 <1471380303.21107.38.camel@linux.intel.com>
Message-ID: <20160816234508.GA12482@localhost.localdomain>

On Tue, Aug 16, 2016@01:45:03PM -0700, J Freyensee wrote:
> On Mon, 2016-08-15@22:41 -0300, Helen Koike wrote:
> > ?		struct nvmf_connect_command connect;
> > ?		struct nvmf_property_set_command prop_set;
> > ?		struct nvmf_property_get_command prop_get;
> > +		struct nvme_doorbell_memory doorbell_memory;
> > ?	};
> > ?};
> 
> This looks like a new NVMe command being introduced, not found in the
> latest NVMe specs (NVMe 1.2.1 spec or NVMe-over-Fabrics 1.0 spec)?
> 
> This is a big NACK, the command needs to be part of the NVMe standard
> before adding it to the NVMe code base (this is exactly how NVMe-over-
> Fabrics standard got implemented). ?I would bring your proposal to
> nvmexpress.org.

While this is an approved TPAR up for consideration soon, I don't think we
want to include this in mainline before it is ratified lest the current
form conflicts with the future spec.

We can still review and comment on the code, though it's not normally
done publicly until the spec is also public. The proposal originated
from a public RFC, though, so it's not a secret.
