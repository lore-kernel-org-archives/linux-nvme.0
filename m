From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Thu, 18 Jul 2019 10:41:53 +1000
Subject: Duplicate tag error with 5.2
Message-ID: <0007d555cf4586c4ae43fdca66766b6b11863078.camel@kernel.crashing.org>

Hi !

So I'm getting occasional abrupt shutdowns on the Mac Mini 2018. I
found out that it's the T2 chip that is panic'ing and shutting the
system down.

Interestingly, when booting into MacOS, we can get some kind of error
log of what happened. It looks like the NVME implementation on that
thing is a SW emulation done by the T2 chip :-) It's failing on an
assert due to a duplicate tag error...

Does that ring any bell ? Any idea what might be causing that ? (tag is
tag 8 if that means anything).

Cheers,
Ben.
