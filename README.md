>## Archived Aras Community Project
*This project has been migrated to GitHub from the old Aras Projects page (http://www.aras.com/projects). As an Archived project, this project is no longer being actively developed or maintained.*

>*For current projects, please visit the new Aras Community Projects page on the updated Aras Community site: http://community.aras.com/projects*

# Outlook Style TOC

Changes the standard Table-of-Contents navigation to look and behave like Outlook navigation.

### Interview with the developer:

#### What the motivator was for the solution?
Since Aras is a very well thought out program based on the Microsoft look and feel, I thought that it would be nice to use the base menu system that Microsoft uses in its B2B applications. Plus I thought since we are an Open User it would be nice to contribute back.

#### Who participated in development (1 guy vs a team etc)?
I am the one who developed the menu system.

#### How it was built, not the secret sauce but the basics (coding vs configuration, etc)?
I had much of the code built for a previous project that I was working on, and after some exploratory searching through Aras's code I saw that a call was being made to attach an xslt stylesheet using the xml from a previous call in the script.

I used Nash and caught the XML code and created a stylesheet that would output the menu as you see today. I then altered the mainTree.html to allow for the functionality needed. The whole process was not has hard has it would seem because I created the menu to use the functions already in place.

#### Any other snipits you think would be valuable to share?
I am sending an updated version of the menu system – now keeps the highlighted menus after you click off the menu.
I am also working on the inBasket to allow certain administrative persons to look at other inBaskets to help with problems. Again, much of the code is ready from Aras, it is just a matter of implementing the change.

#### *As seen at the ACE 2010 event!*

## History

Release notes/descriptions for the original project posted on the previous Aras Projects page.

Release | Notes
--------|--------
[v2.0](https://github.com/ArasLabs/outlook-style-toc/releases/tag/v2.0) | 2nd release (Apr 2011).
[v1.0](https://github.com/ArasLabs/outlook-style-toc/releases/tag/v1.0) | First release as a Community project. INSTALL Instructions - there is no package or any itemtype changes required. This is a replacement of one file in the client code tree, and then some additional icons and style sheets. Before installing, be sure to backup ../client/scripts/mainTree.htm then just unzip the attached file. You might need to stop / start IIS or flush the browser cache before you see the change.

#### Supported Aras Versions

Project | Aras
--------|------
[v2.0](https://github.com/ArasLabs/outlook-style-toc/releases/tag/v2.0) | Aras 9.1
[v1.0](https://github.com/ArasLabs/outlook-style-toc/releases/tag/v1.0) | Aras 9.1

> ###### *Please note: Aras Community Projects are provided on an "as-is" basis.*

>*Due to the wide array of possible business requirements, customizations, and use cases, we cannot guarantee compatibility or support for any given project.*

>*If you experience issues with this or any other Aras Community Project, please contact the project author and file an issue on the project's GitHub repository. You can also check out the [Aras Developer Forums](http://community.aras.com/forums/) to see if any other community members have experienced the same issue.*

## Credits

**Project Owner:** Peter Schroer, Aras Corporation

**Original Idea:** Kevin Friske

**Created On:** May 28, 2010

## License

This project is published under the Microsoft Public License license (MS-PL). See the [LICENSE file](./LICENSE.md) for license rights and limitations.
