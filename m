From: vedant@lath.in (Vedant Lath)
Date: Wed, 11 Nov 2015 03:58:16 +0530
Subject: nvme: controller resets
In-Reply-To: <20151110155110.GA31697@localhost.localdomain>
References: <33aa688b8da3f41960d36e66aa1703d8@localhost>
 <20151110155110.GA31697@localhost.localdomain>
Message-ID: <CAKajsGOdxWzK8TfpaLYpf25h=ZRfQbxRW47Q4aAHhCOunLK+FQ@mail.gmail.com>

On Tue, Nov 10, 2015@9:21 PM, Keith Busch <keith.busch@intel.com> wrote:
> Not sure really. Normally I file a f/w bug for this kind of thing. :)
>
> But I'll throw out some potential ideas. Try trottling driver capabilities
> and see if anything improves: reduce queue count to 1 and depth to 2
> (requires code change).
>
> If you're able to recreate with reduced settings, then your controller's
> failure can be caused by a single command, and it's hopefully just a
> matter of finding that command.
>
> If the problem is not reproducible with reduced settings, then perhaps
> it's related to concurrent queue usage or high depth, and you can play
> with either to see if you discover anything interesting.
>
> Of course, I could be way off...

Is there any way to monitor all the commands going through the wire?
Wouldn't that help? That would at least tell us which NVMe command
results in a reset, and the flow of the commands leading up to the
reset can give us more context into the error.
