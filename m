From: keith.busch@intel.com (Keith Busch)
Date: Tue, 16 Aug 2016 12:35:02 -0400
Subject: [PATCH v3 nvme-cli 0/4] Useful fabrics patches
In-Reply-To: <1471340787-26922-1-git-send-email-sagi@grimberg.me>
References: <1471340787-26922-1-git-send-email-sagi@grimberg.me>
Message-ID: <20160816163502.GB21721@localhost.localdomain>

On Tue, Aug 16, 2016@12:46:23PM +0300, Sagi Grimberg wrote:
> hey keith,
> 
> changes from v2:
> - read 223 bytes from hostnqn file
> - some styling review fixes on the stringify patch
> - modified the adrfam statement to a proper switch-case
> 
> changes from v1:
> - fixed review comments from christoph
> - added a patch to take hostnqn from a default conf file if it
>   exists (and a hostnqn param wasn't given, patches by jay and roy)
> 
> Sagi Grimberg (4):
>   fabrics: Allow ipv6 address resolution
>   fabrics: stringify discover output.
>   fabrics: Allow discover params to come from a conf file
>   fabrics: Take the hostnqn parameter from a conf file if not given

Thanks, Sagi. All applied and pushed to github.
