From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Tue, 17 Apr 2018 18:48:36 -0400
Subject: [PATCH] nvme: Set integrity flag for user passthrough commands
In-Reply-To: <20180417220535.14755-1-keith.busch@intel.com> (Keith Busch's
 message of "Tue, 17 Apr 2018 16:05:35 -0600")
References: <20180417220535.14755-1-keith.busch@intel.com>
Message-ID: <yq1tvs9phyz.fsf@oracle.com>


Keith,

> If the command a separate metadata buffer attached, the request needs
> to have the integrity flag set so the driver knows to map it.

Yup.

Reviewed-by: Martin K. Petersen <martin.petersen at oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
