From: james.smart@broadcom.com (James Smart)
Date: Tue, 7 May 2019 09:47:31 -0700
Subject: [PATCH nvme-cli rfc 0/6] Support discovery log change events
In-Reply-To: <alpine.LRH.2.21.9999.1905061528390.19585@mvluser05.qlc.com>
References: <20190223023257.21227-1-sagi@grimberg.me>
 <d4012891-8bc7-00cf-ab96-7828270d25af@suse.de>
 <e7423c76-6425-4020-2074-b977fc87866f@grimberg.me>
 <d1742744-1109-e7e8-3586-fca6556c803b@broadcom.com>
 <d7bbfc2a-92ea-315d-bbd6-cd3847449f7b@grimberg.me>
 <3b524b54-8f13-24f5-4367-34a4d02c59b3@broadcom.com>
 <5c64286b-3fbf-9dfe-ef8a-3f72e630f11d@broadcom.com>
 <a4f8ca74-7777-9e80-3209-ef9ce27ad2d8@suse.de>
 <44f637f2-0c0d-cef4-05b3-c5e67ec907bb@grimberg.me>
 <f0e112f7-0db5-4928-0859-8b3b6b797432@grimberg.me>
 <9d0e3080-baa7-6f55-2548-097523bb3a83@suse.de>
 <03163041-9b14-3662-edb8-1d69f20f681f@grimberg.me>
 <f4594084-4f2a-33ca-77b4-d7075bbb12af@broadcom.com>
 <2a08f760-0aeb-d788-3210-72ec9d6eb9bc@grimberg.me>
 <3b7117cf-db69-01a3-d286-a2f98f3e8f5b@broadcom.com>
 <alpine.LRH.2.21.9999.1905061528390.19585@mvluser05.qlc.com>
Message-ID: <a6c04837-bcf1-0fb6-12c2-0d1f140d6ce9@broadcom.com>



On 5/6/2019 3:38 PM, Arun Easi wrote:
> Hi James,
>
> On Fri, 26 Apr 2019, 1:14pm, James Smart wrote:
>
>> On 4/26/2019 12:10 PM, Sagi Grimberg wrote:
>>> Given that FC does not need a persistent discovery controller to get the
>>> event, its fine that it will create a temporary discovery controller.
>>> Given that FC and IP do different things, we can separate them. But what
>>> I wanted to understand, is if I export a second subsystem on the same
>>> FC port, will it generate an FC event?
>> Well - FC does have an RSCN notification to cause the rescan of the FC
>> port, if the FC port as the NVME Discovery attribute, but Christoph
>> rejected the 3 patches about a year ago. I'll be reposting it. So the
>> answer should eventually be - yes, it will get an FC event if the
>> subsystem list at the FC port changes.
>>
> So, just wondering, for the case of subsystem addition to an existing FC
> port, is it recommended or mandated in the spec that the target FC port
> send out a RSCN? The RSCN should be from the target FC port, not the
> switch, right? I could not find such a reference in the FC-NVME spec
> version I have (r1.15).
>
> On a related note, from a FC LLDD perspective, then, are they required to
> invoke nvme_fc_rescan_remoteport() upon RSCN reception?
>
> Regards,
> -Arun

There's no requirement, but there is a recommendation. Should be in 
section C.? RSCN should be from the FC port, but it can address the 
fabric and have the fabric deliver it to the recipients.

you need to be looking at at least r1.19 + ammendment 1.

For the FC LLDD perspective - I had pushed the api into the initiator 
transport where the driver can invoke the rescan, but it wasn't picked 
up. I'm about to repost after merging with similar work done with the 
disovery AEN work on the nvmet side.?? Also, for proper 1.19+ammendment 
1 support, I will be adding an LS-receive interface to the transport - 
so that Disconnects and (soon) Disconnect I/O Connections can be passed up.

-- james
