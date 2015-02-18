From: jim@thebergstens.com (James R. Bergsten)
Date: Wed, 18 Feb 2015 09:39:47 -0800
Subject: Async Event test
In-Reply-To: <54E4C2CD.3090308@gmail.com>
References: <54E4C2CD.3090308@gmail.com>
Message-ID: <4e2101d04ba1$e5d82530$b1886f90$@thebergstens.com>

Hi, Olivier.

Cannot speak for everyone or even suggest a specific Linux solution for that
matter, but here's what "I" did to test other vendor's async event handling:

- Started one or more Asynchronous Event Request operations, then

- Issued operations in error to insure that the AER ended and contained a
valid response.

Amongst other things, I tried writing an invalid doorbell value (past the
queue length), and an invalid LBA (past the size of the device).

I suggest this so that you do not have to make any specific changes on the
controller side to support this "black box" test (well, other than to make
sure the controller works in the first place).

Good luck.
Jim B.

-----Original Message-----
From: Linux-nvme [mailto:linux-nvme-bounces@lists.infradead.org] On Behalf
Of Olivier Mallinger
Sent: Wednesday, February 18, 2015 8:50 AM
To: linux-nvme at lists.infradead.org
Subject: Async Event test

Hello.

I want to test the asynchronous event xith my controller.
Has this feature been implemented in the Linux driver ?

I want to request asynchronous event to my controller, then I will
instrument my controller to simulate event.
I don't know what is going to do the driver in such case and how to have
access to the asynchronous event information.
Do you have any solutions to test it ?

Thanks.
Regards.
Olivier.


_______________________________________________
Linux-nvme mailing list
Linux-nvme at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
