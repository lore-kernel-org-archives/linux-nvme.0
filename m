From: keith.busch@intel.com (Keith Busch)
Date: Wed, 18 Jan 2017 12:13:47 -0500
Subject: [PATCH nvme-cli v3 0/3] auto generate hostnqn file on installation
In-Reply-To: <1484219610-18370-1-git-send-email-sagi@grimberg.me>
References: <1484219610-18370-1-git-send-email-sagi@grimberg.me>
Message-ID: <20170118171347.GB16243@localhost.localdomain>

On Thu, Jan 12, 2017@01:13:27PM +0200, Sagi Grimberg wrote:
> This set is designed to help the user by auto-generating a hostnqn and
> placing it in /etc/nvme/hostnqn file upon installation of nvme-cli (in
> case such a file doesn't exist).
> 
> The user can re-generate different hostnqns on demand by running:
> $ nvme gen-hostnqn

Thanks, I've applied the series and regenerated the documentation to create
the man page you've added.
