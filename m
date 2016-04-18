From: mlin@kernel.org (Ming Lin)
Date: Mon, 18 Apr 2016 10:52:39 -0700
Subject: Namespace removal deadlock in case of namespace detach command
In-Reply-To: <20160418145756.GA4640@localhost.localdomain>
References: <168786720.663071460980851178.JavaMail.weblogic@ep2mlwas04b>
 <20160418145756.GA4640@localhost.localdomain>
Message-ID: <CAF1ivSaOuFphqevFvV-4gCHEAww4p9n0nvsfH-MVM3ovucfu7Q@mail.gmail.com>

On Mon, Apr 18, 2016@7:57 AM, Keith Busch <keith.busch@intel.com> wrote:
> On Mon, Apr 18, 2016@12:00:51PM +0000, Sunad Bhandary S wrote:
>> On receipt of a namespace attribute changed AER, we acquire the namespace mutex lock before proceeding to scan and validate the namespace list.
>> In case of namespace detach/delete command, nvme_ns_remove function deadlocks trying to acquire the already held lock.
>
> You're right, thanks for the catch. Do you have a fix, or should we
> propose one?

We have a fix in nvme over fabrics tree.
Let me post here soon.
