From: keith.busch@intel.com (Keith Busch)
Date: Wed, 24 Aug 2016 10:58:39 -0400
Subject: [PATCH] nvme-cli/fabrics: Added hostnqn parameter to connect
 command
In-Reply-To: <1472021586-15203-1-git-send-email-roysh@mellanox.com>
References: <1472021586-15203-1-git-send-email-roysh@mellanox.com>
Message-ID: <20160824145839.GA13337@localhost.localdomain>

On Wed, Aug 24, 2016@09:53:06AM +0300, Roy Shterman wrote:
> Added user-defined 'hostnqn' to 'connect' command
> so users could use the allowed_hosts attribute on the target and still
> connect to target with nvme-cli tool.
> 
> usage examples:
> 	nvme connect -t <TRANSPORT> -a <ADDRESS> -s <SERVICE_ID> -n <NQN> -q <USER-DEFINED_HOSTNQN>
> 
> Signed-off-by: Roy Shterman <roysh at mellanox.com>

Applied, thanks.
