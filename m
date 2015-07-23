From: paul.grabinar@ranbarg.com (Paul Grabinar)
Date: Thu, 23 Jul 2015 21:22:30 +0100
Subject: nvme-cli format timeout
In-Reply-To: <alpine.LNX.2.00.1507232009580.15930@localhost.lm.intel.com>
References: <55B14899.5000407@ranbarg.com>
 <alpine.LNX.2.00.1507232009580.15930@localhost.lm.intel.com>
Message-ID: <55B14D06.6010502@ranbarg.com>

On 23/07/15 21:11, Keith Busch wrote:
> On Thu, 23 Jul 2015, Paul Grabinar wrote:
>> Hi,
>>
>> I am aware of some NVMe drives that take well over 60 seconds to perform
>> a format and therefore timeout during the format command issued by
>> nvme-cli.
>>
>> We might want to consider increasing the timeout. The following patch is
>> an example to show what I mean.
>
> Good idea. We should probably make this a parameter as well as up
> the timeout. Only the passthru command takes the timeout request as a
> parameter for some reason.
>
> If you want to post a pull request on github, we can apply it from there.
>

Thanks.
I'll post a pull request. As you say though, having a timeout parameter
would probably be even better.
