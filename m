From: hch@lst.de (Christoph Hellwig)
Date: Thu, 9 Nov 2017 18:10:19 +0100
Subject: building nvmetcli in buildroot
In-Reply-To: <CANqv2T0CL+hJz0+_yUBnwQ995mupBTOBMpqEcrvi9ZawDBBCtg@mail.gmail.com>
References: <CANqv2T0CL+hJz0+_yUBnwQ995mupBTOBMpqEcrvi9ZawDBBCtg@mail.gmail.com>
Message-ID: <20171109171019.GA15304@lst.de>

I'm perfectly happy to make life for buildroots easier, but nvmetcli
is an admin tool that should live in /usr/sbin.  We'll need to find
a way for that to still be the default.
