From: keith.busch@intel.com (Keith Busch)
Date: Fri, 11 Apr 2014 14:04:31 -0600 (MDT)
Subject: Suggested nvme driver version to compile into RHEL/CentOS
 2.6.32-431 (or similar)
In-Reply-To: <53482955.1050807@aeoncomputing.com>
References: <53482955.1050807@aeoncomputing.com>
Message-ID: <alpine.LRH.2.03.1404111336320.4731@AMR>

On Fri, 11 Apr 2014, Jeff Johnson wrote:
> Greetings,
>
> Is there a version of the nvme driver that is known to compile into a
> RHEL/Centos 2.6.32-431 or similarly aged kernel version?

Is there something wrong with the driver Red Hat included with
2.6.32-431? I'm sure RH provides the source for it.

If you're going for a pre-RHEL6.5, there's this compatibility repo:

git.infradead.org/users/kbusch/nvme-compatibility.git

It hasn't been updated in a long while, though. I intended to better
maintain it as a reference for the older distros, but the upstream driver
is using so many newer kernel APIs that it became too much work to keep
this back-port aligned (I'd still take outside contributions!)
