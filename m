From: luto@amacapital.net (Andy Lutomirski)
Date: Mon, 18 Jan 2016 15:23:31 -0800
Subject: Anyone working on nvme power management?
Message-ID: <CALCETrUDmjXDYzHrhpS=0UokebFys4rWhot5Ti1dxa=KX_9+9g@mail.gmail.com>

It looks like the nvme spec allows both nvme-specific low power states
and D3.  Is anyone working on supporting either of these in the Linux
driver?

Also, the host memory buffer feature seems related, although I can't
find anything in the spec saying what its purpose is.  Is it related
to the power management features?  Does it give faster low-power
exits?

--Andy
