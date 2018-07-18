From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 18 Jul 2018 14:26:31 +0300
Subject: [PATCH v3 1/1] nvme: Ensure forward progress during Admin passthru
In-Reply-To: <20180717124252.GA14724@infradead.org>
References: <20180622195914.18575-1-scott.bauer@intel.com>
 <20180629190328.2096-1-scott.bauer@intel.com>
 <20180629202350.GB13865@localhost.localdomain>
 <20180716220940.GA26925@localhost.localdomain>
 <20180717124252.GA14724@infradead.org>
Message-ID: <6e9e61bd-7c0c-90ae-17c8-8b8ef6ed588f@grimberg.me>


>> Christoph,
>> Could we get this one queued up for next?
> 
> Will look at it ASAP.

Would be good if the change log would explain _how_ it
ensures forward progress.. i.e. that it moves namespaces
list mutation to nvme_remove_invalid_namespaces which allows
to acquire namespaces_rwsem as a read lock, allowing dev_disable
to stop controller queues (acquiring a read lock as well) in case
a timeout have occured on a passthru command.
