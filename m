From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 24 Jun 2016 01:12:35 -0700
Subject: [PATCH 1/3] nvme: When scanning namespaces, make sure the drive
 is not locked
In-Reply-To: <20160619230634.17229-2-kernel@jbeekman.nl>
References: <20160619230634.17229-1-kernel@jbeekman.nl>
 <20160619230634.17229-2-kernel@jbeekman.nl>
Message-ID: <20160624081235.GA12715@infradead.org>

On Sun, Jun 19, 2016@04:06:32PM -0700, Jethro Beekman wrote:
> +	if (nvme_security_is_locked(ctrl, id)) {
> +		nvme_remove_namespaces(ctrl);
> +		return;
> +	}

Should we print some information for the user that we are ignoring
a namespace because it is locked?
