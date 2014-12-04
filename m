From: Stephen.Bates@pmcs.com (Stephen Bates)
Date: Thu, 4 Dec 2014 22:35:04 +0000
Subject: NVM Express 1.2 - Controller Memory Buffer Functionality.
Message-ID: <36F6EBABA23FEF4391AF72944D2289016EC8C680@BBYEXM01.pmc-sierra.internal>

Hi All

My first post to this list so please be gentle. Apologies in advance if this has already been discussed by the mailing list.

I was wondering if anyone has given any thought to updating the Linux NVMe driver based on the features added in 1.2? I am particularity interested in the Controller Memory Buffer functionality. I am willing to put some time and effort into this but was wondering if anyone else had already started? 

For those of you who do not know, this feature allows a NVMe device to expose a pre-determined amount of memory that can (optionally) be used for staging IO data, storing queues etc. See Section 4.7 of version 1.2 of the specification for more details.

Cheers

Stephen
