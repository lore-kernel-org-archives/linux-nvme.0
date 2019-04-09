From: jsmart2021@gmail.com (James Smart)
Date: Tue, 9 Apr 2019 14:25:47 -0700
Subject: [PATCH] nvme-cli: Revert stop-on-failure with connect-all
In-Reply-To: <20190409210448.GA3272@localhost.localdomain>
References: <20190409205154.15197-1-jsmart2021@gmail.com>
 <20190409210448.GA3272@localhost.localdomain>
Message-ID: <b84a5abd-61d2-c4f0-c4ce-e77791841cfb@gmail.com>

On 4/9/2019 2:04 PM, Keith Busch wrote:
> On Tue, Apr 09, 2019@01:51:54PM -0700, James Smart wrote:
>> The patch that added special treatment for EALREADY connect failures
>> also changed the behavior on what happens if a discovery log contains
>> an entry that is not connectable by the system or host port. If it
>> encounters a log entry that can't be connected to, it will not attempt
>> to connect to any log entries beyond it. This can leave lots of devices
>> unconnected to.
>>
>> Revert the stop-on-failure introduced by the previous patch.
>>
>> Specifically, this failed for me on an FC array that had a discovery log
>> entry for a port that was not visible via zoning for the initiator
>> port being used.
> 
> Patch applied. I just tagged a release earlier this week, so let me know
> if this is urgent enough to warrant a new tag.
> 

I believe it is unfortunately.  It seems to be a fairly common thing.

-- james
