From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 2 Aug 2016 09:48:28 +0300
Subject: [PATCH v2] nvme-cli: user-defined hostnqn option for discover
In-Reply-To: <1470087179.6134.51.camel@linux.intel.com>
References: <1469824719-7378-1-git-send-email-james_p_freyensee@linux.intel.com>
 <1469824719-7378-2-git-send-email-james_p_freyensee@linux.intel.com>
 <20160801111859.GA28246@infradead.org>
 <1470087179.6134.51.camel@linux.intel.com>
Message-ID: <7561e238-9063-ceec-2b47-47ffd3607a42@grimberg.me>


>> Any chance you could also send a patch that reads /etc/nvme/hostnqn
>> for a default hostnqn so that we can have a persistent one?
>
> I'm a tad unclear what is the request? The default hostnqn is buried
> inside /dev/nvme-fabrics.  You want nvme-cli to read out the default
> hostnqn from /dev/nvme-fabrics and place it in  /etc/nvme/hostnqn?

I think Christoph is requesting that when the user doesn't pass a
hostnqn, nvme-cli will try to read it from a file located in
/etc/nvme/hostnqn (and if this doesn't exist then go ahead without
it). This way, the host can have a persistent hostnqn across reboots
(the driver generates one on module init time).
