From: james_p_freyensee@linux.intel.com (J Freyensee)
Date: Thu, 11 Aug 2016 09:33:42 -0700
Subject: [PATCH RFC 1/4] fabrics: define admin sqsize min default, per spec
In-Reply-To: <20160811150846.GA19738@lst.de>
References: <1470888438-823-1-git-send-email-james_p_freyensee@linux.intel.com>
 <1470888438-823-2-git-send-email-james_p_freyensee@linux.intel.com>
 <be1a6027-04f5-815d-ba2a-89529087dab4@grimberg.me>
 <20160811150846.GA19738@lst.de>
Message-ID: <1470933222.2796.1.camel@linux.intel.com>

On Thu, 2016-08-11@17:08 +0200, Christoph Hellwig wrote:
> On Thu, Aug 11, 2016@12:01:59PM +0300, Sagi Grimberg wrote:
> > 
> > it with the non-default value. I honestly don't see the reason
> > to keep it in a variable when no one is making real use
> > of it.
> > 
> > If you would have exposed it to user-space then it would make
> > better sense (although I'm not a fan of adding not very useful
> > configs to user-space).
> 
> I agree - until we have a good use case for large admin queues
> we should keep things simple.??And I'm still pissed about the idiotic
> addition of the admin queue size to the discovery records in the last
> moment.??It's entirely contrary to the disccovery service abstraction
> we build, and pointless as well.??So the more we can ignore it, the
> better.

OK, I have no problems with that. ?So #define set the admin sqsize in
nvmf_connect_admin_queue() OK?
