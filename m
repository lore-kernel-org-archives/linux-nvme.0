From: keith.busch@linux.intel.com (Keith Busch)
Date: Wed, 6 Jun 2018 08:28:57 -0600
Subject: blktests block/019 lead system hang
In-Reply-To: <1cbee034-d237-104d-bf5a-33e373821301@redhat.com>
References: <838678680.4693215.1527664726174.JavaMail.zimbra@redhat.com>
 <1858098161.4693883.1527665214701.JavaMail.zimbra@redhat.com>
 <20180605161853.GB16899@localhost.localdomain>
 <20180605172112.GC17057@localhost.localdomain>
 <1cbee034-d237-104d-bf5a-33e373821301@redhat.com>
Message-ID: <20180606142857.GA19462@localhost.localdomain>

On Wed, Jun 06, 2018@01:42:15PM +0800, Yi Zhang wrote:
> Here is the output, and I can see "HotPlug+ Surprise+" on SltCap

Thanks. That looks like a perfectly capable port. I even have the same
switch in one of my machines, but the test doesn't trigger fatal
firmware-first errors.

Might need to query something about the platform to know how it treats
link-downs before proceeding with the test (don't know off the top of
my head; will do some digging).
