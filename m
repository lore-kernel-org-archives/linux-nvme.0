From: javigon.napster@gmail.com (=?utf-8?Q?Javier_Gonz=C3=A1lez?=)
Date: Mon, 19 Feb 2018 14:40:32 +0100
Subject: [PATCH 2/8] lightnvm: show generic geometry in sysfs
In-Reply-To: <dc558965-9c1f-26f1-9274-12a6f8057825@lightnvm.io>
References: <1518530768-20956-1-git-send-email-javier@cnexlabs.com>
 <1518530768-20956-3-git-send-email-javier@cnexlabs.com>
 <caa2634b-63bf-3a35-ed53-220aab2bd05a@lightnvm.io>
 <E53B65E9-3D1A-49BB-AA5D-F3D2C4032484@cnexlabs.com>
 <dc558965-9c1f-26f1-9274-12a6f8057825@lightnvm.io>
Message-ID: <F72BAE57-88B8-447B-B0D2-7EB6AE8105A2@gmail.com>


>>> This breaks user-space. The intention is for user-space to decide
>>> based on version id. Then it can either retrieve the 1.2 or 2.0
>>> attributes. The 2.0 attributes should not be available when a device
>>> is 1.2.
>>> 
>> Why does it break it? I'm only adding new entries.
>> The objective is to expose the genneric geometry, since this is the
>> structure that is passed on to the targets. Since some of the values are
>> calculated, there is value on exposing this information, I believe.
>> Another way of doing it, is adding the generic geometry at the target
>> level, showing what base values it is getting, including the real number
>> of channels/groups and luns/pus.
>> Would this be better in your opinion?
> 
> No. It should be one set of attributes for 1.2 (keep the way it is today), and then separate 2.0 attributes. User-space should then identify either by either 1 or 2 in the version attribute.
> 
>>>> ...

>>> csecs and sos are derived from the the generic block device data structures.
>> As mentioned above, it is to represent the generic geometry.
> 
> They are not part of the 2.0 spec. The fields can be derived from elsewhere.
>>> 

Ok. Thanks for looking into it. 

Javier. 
