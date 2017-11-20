From: thomas.tai@oracle.com (Thomas Tai)
Date: Mon, 20 Nov 2017 15:11:28 -0500
Subject: parse_and_open without closing the fd
In-Reply-To: <20171120201333.GB12587@localhost.localdomain>
References: <1c333ba1-5371-fa03-12fa-72ae42c7cc52@oracle.com>
 <20171120201333.GB12587@localhost.localdomain>
Message-ID: <13087d0e-c7e7-521b-e029-6f6a71e153ba@oracle.com>



On 2017-11-20 03:13 PM, Keith Busch wrote:
> On Mon, Nov 20, 2017@03:04:36PM -0500, Thomas Tai wrote:
>> I am trying to add a new command in nvme-cli and use flush() in nvme.c as an
>> example. The flush command use parse_and_open() to open the fd, but it never
>> close the fd. I am wondering where about the fd is being closed.
> 
> It's implicitly closed on exit. This is a short-lived one-shot program,
> so there is some laziness with accounting for all resources that are
> automatically reclaimed. That said, it's still nice to clean this up as
> we find such examples.
> 

I see. Thanks Keith for your quick response.

-Thomas
