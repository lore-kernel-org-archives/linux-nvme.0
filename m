From: jsmart2021@gmail.com (James Smart)
Date: Thu, 18 Jul 2019 18:22:37 -0700
Subject: [PATCH 07/10] nvme-cli: Add routine to search for controller with
 specific attributes
In-Reply-To: <6b3ebb18-4b8c-c18e-501d-cd8f1f41c676@grimberg.me>
References: <20190716211241.7650-1-jsmart2021@gmail.com>
 <20190716211241.7650-8-jsmart2021@gmail.com>
 <20190717115711.GD10495@minwoo-desktop>
 <6b3ebb18-4b8c-c18e-501d-cd8f1f41c676@grimberg.me>
Message-ID: <daca2393-86ff-f9ec-cf7c-15c33990de7c@gmail.com>

On 7/18/2019 5:35 PM, Sagi Grimberg wrote:
> 
>>> +??? for (i = 0; i < n; i++) {
>>> +??????? if (ctrl_matches_connectargs(devices[i]->d_name, args)) {
>>> +??????????? devname = strdup(devices[i]->d_name);
>>> +??????????? if (devname == NULL)
>>> +??????????????? fprintf(stderr, "no memory for ctlr name %s\n",
>>
>> nitpick: s/ctlr/ctrl
>>
>> Maybe it can be updated when it gets merged.
> 
> Yea, lets change that (either james or keith)

NP. I'll plan on posting a v2 with the 2 small comments resolved (this 
print, Hannes's order).

I've been toying with tweaking the parse routines. I'm wondering if 
passing the connect args string to ctrl_matches_connectargs() is better 
than creating a new structure to pass it.  It would mean we would parse 
the base connect args strings perhaps multiple times, but it sure 
localizes the parsing to the matches routine and eliminates the new 
structure.  Thoughts ?

-- james
