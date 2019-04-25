From: keith.busch@intel.com (Keith Busch)
Date: Thu, 25 Apr 2019 08:59:48 -0600
Subject: [PATCH 1/2] spec, Makefile: add /etc/nvme files to package files
In-Reply-To: <20190424214942.11288-1-sagi@grimberg.me>
References: <20190424214942.11288-1-sagi@grimberg.me>
Message-ID: <20190425145947.GB17869@localhost.localdomain>

On Wed, Apr 24, 2019@02:49:41PM -0700, Sagi Grimberg wrote:
> This way it can automatically be removed upon uninstallation
> and we don't need %preun target. Also, this will also allow
> to get these files on manual installation from sources.
> 
> Also, don't settle on the "file exists" check, use the '-s'
> to check that it is not empty as well.
> 
> Lastly, in order to have hostnqn and hostid updated upon pkg
> install, we have install-spec target that would omit hostnqn and
> hostid files, and let the rpm %post do it (otherwise we
> use the normal install target).

Sounds good, applied both patches.
