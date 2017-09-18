From: james.smart@broadcom.com (James Smart)
Date: Mon, 18 Sep 2017 09:28:35 -0700
Subject: [PATCH v3 3/3] nvme_fc: Avoid duplicate associations between same
 port pairs
In-Reply-To: <20170918161219.GB310@infradead.org>
References: <20170914173843.3195-1-jsmart2021@gmail.com>
 <20170914173843.3195-4-jsmart2021@gmail.com>
 <20170918161219.GB310@infradead.org>
Message-ID: <7f610102-562c-18e0-659a-ff06b0186ac2@broadcom.com>

On 9/18/2017 9:12 AM, Christoph Hellwig wrote:
> On Thu, Sep 14, 2017@10:38:43AM -0700, James Smart wrote:
>> Rescans can occur due to subsystem list changes on an FC remoteport.
>> Rescans may attempt to reconnect to subsystems where there is already
>> an association in place. There should only be 1 association in place
>> at a time for the following tuple:
>>    <hostnqn, hostid, host FC port, target FC port, subnqn>
> There is absolutely no requirement for this limitation in the NVMe
> spec.

True. But it makes little sense to allow it as it creates a 2nd 
controller, thus multiple devices for the namespaces, along the same "hw 
path".? I.e. now multipath has 2 nvme devices for the same hw path with 
no changes in availability and consuming more resources on host and target.

The desire for FC is to have the same dynamic discovery that it has for 
SCSI. Thus the udev events that kick off scanning. The events are posted 
when connectivity is first detected as well as conditions where the 
discovery server content may have changed (new subsystems added for 
example).? Since those events are ignorant of what's already connected, 
it make no sense to create additional controllers/devices if there's 
already a controller connected.

The alternative is to drive all connections manually which makes a very 
difficult to manage system for an administrator, especially on 
"cable-pull" scenarios. There is no need for this with FC.

-- james
