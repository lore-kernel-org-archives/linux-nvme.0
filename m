From: hch@lst.de (Christoph Hellwig)
Date: Fri, 10 Nov 2017 09:19:17 +0100
Subject: building nvmetcli in buildroot
In-Reply-To: <CANqv2T2Uhy__zyQY-tixnfFmCYOZV7y=grmsgtshRkhx6nwoLw@mail.gmail.com>
References: <CANqv2T0CL+hJz0+_yUBnwQ995mupBTOBMpqEcrvi9ZawDBBCtg@mail.gmail.com>
 <20171109171019.GA15304@lst.de>
 <CANqv2T2Uhy__zyQY-tixnfFmCYOZV7y=grmsgtshRkhx6nwoLw@mail.gmail.com>
Message-ID: <20171110081917.GA4056@lst.de>

On Fri, Nov 10, 2017@08:43:05AM +0100, stephane gonauer wrote:
> Hi,
> 
> I dug further into the question to better understand.
> 
> >From my understanding the root cause lies in setuptools :
> 
> - buildroot uses --prefix option to set the prefix to $(TARGET_DIR)
> - the setup.cfg from nvmetcli uses -install-script
> - When both options are present, install-script completely overrides
> --prefix and is considered as an absolute path.
> 
> I tried to uses $(TARGET_DIR) inside setup.cfg but it is not evaluated
> when reaching setup.cfg (and it results in a path containing the
> TARGET_DIR and not its value).
> 
> Unless someone knows how to better use setuptools, I don't see a
> solution inside nvmetcli tree

What do other python tools that install into sbin or similar use?
There must be all kinds of precedence for this..
