From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 8 Nov 2018 01:58:01 -0800
Subject: [PATCH v2 09/11] nvmet: allow host connect even if no allowed
In-Reply-To: <1539709883-12424-10-git-send-email-jay.e.sternberg@intel.com>
References: <1539709883-12424-1-git-send-email-jay.e.sternberg@intel.com>
 <1539709883-12424-10-git-send-email-jay.e.sternberg@intel.com>
Message-ID: <20181108095801.GJ29432@infradead.org>

> +bool nvmet_host_allowed(struct nvmet_subsys *subsys, const char *hostnqn)
>  {
>  	lockdep_assert_held(&nvmet_config_sem);
>  
>  	if (subsys->type == NVME_NQN_DISC)
> -		return nvmet_host_discovery_allowed(req, hostnqn);
> +		return true;
>  	else
>  		return __nvmet_host_allowed(subsys, hostnqn);

Please merge __nvmet_host_allowed into nvmet_host_allowed, with an
early return for the NVME_NQN_DISC case.  Please also write a comment
explaining that special case.
