From: jack@suse.cz (Jan Kara)
Date: Thu, 25 Jan 2018 10:37:24 +0100
Subject: [LSF/MM TOPIC] few MM topics
In-Reply-To: <20180124092649.GC21134@dhcp22.suse.cz>
References: <20180124092649.GC21134@dhcp22.suse.cz>
Message-ID: <20180125093724.h3j6m3d4msblyhgy@quack2.suse.cz>

Hi,

On Wed 24-01-18 10:26:49, Michal Hocko wrote:
> - we have grown a new get_user_pages_longterm. It is an ugly API and
>   I think we really need to have a decent page pinning one with the
>   accounting and limiting.

I'm interested in this topic from NVDIMM/DAX POV as well as due to other
issues filesystems currently have with GUP (more on that in a topic
proposal I'll send in a moment).

								Honza

-- 
Jan Kara <jack at suse.com>
SUSE Labs, CR
