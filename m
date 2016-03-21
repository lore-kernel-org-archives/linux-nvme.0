From: peter@picnicpark.org (Peter Amidon)
Date: Mon, 21 Mar 2016 08:14:02 -0700
Subject: Samsung NVMe SSD discard option?
Message-ID: <81io0foocl.fsf@DIY-PC.picnicpark.org>

I'm trying to set up an MS Surface Book with Linux, and am unsure
whether I should enable discard support on the internal NVMe SSD, which
appears to be a Samsung device (lspci: "Samsung Electronics Co Ltd
Device a802 (rev 01)").  I was planning on setting this up with an ext4
filesystem, so I need to manually enable discard if necessary.  I found
an Intel Linux reference guide [1] which recommends disabling discard
support, but I also found a presentation [2] which seems to indicate
that discard is well-supported by Linux now.  Since I have a Samsung
drive, and this mailing list seems to have had a number of patches about
discard support, I'm not sure whether the advice in the guide still
applies.

This question seems to have been asked on this list once before as a
side note at [3], but I've been unable to find a definitive response in
the archives; I apologize sincerely if I have missed something which
answers this question.


[1] https://downloadmirror.intel.com/23929/eng/Intel_Linux_NVMe_Driver_Reference_Guide_330602-002.pdf
[2] http://www.flashmemorysummit.com/English/Collaterals/Proceedings/2014/20140804_Seminar_F_Busch.pdf
[3] http://lists.infradead.org/pipermail/linux-nvme/2015-December/003428.html
