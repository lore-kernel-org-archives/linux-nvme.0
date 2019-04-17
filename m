From: kbusch@kernel.org (Keith Busch)
Date: Wed, 17 Apr 2019 16:46:18 -0600
Subject: [PATCH] nvme-cli: Increase size of ONTAP namespace path variable
In-Reply-To: <20190416132740.18045-1-sschricker@suse.de>
References: <20190416132740.18045-1-sschricker@suse.de>
Message-ID: <20190417224618.GA6632@localhost.localdomain>

On Tue, Apr 16, 2019@06:27:40AM -0700, Simon Schricker wrote:
> nspath's size is ONTAP_NS_PATHLEN and is written to by:
> 
> snprintf(nspath, ONTAP_NS_PATHLEN, "%s%s%s%s", ontap_vol,
>                         vol_name, "/", ns_name);
> 
> Required bytes:
> 
> - ontap_vol is a constant char pointer, set to "/vol/", so 5 bytes
> - vol_name's size is ONTAP_LABEL_LEN, which is 260, deducting the
>   null-byte for termination makes 259 required bytes
> - "/" is 1 byte
> - ns_name's size is also ONTAP_LABEL_LEN, which is 260, deducting
>   the null-byte for termination makes 259 required bytes
> - the final null-byte: 1
> 
> That makes in total 5 + 259 + 1 + 259 + 1 = 525 required bytes

Applied, thanks.
