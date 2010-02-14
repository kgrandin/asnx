#ifndef XNODE_H
#define XNODE_H

#include <iostream>

extern char g_yy_expr_current_string[];

class XNode
{
    public:
    XNode() : _value("(base)") {}
    virtual std::string value()
    {
        return _value;
    }

#if 0
    virtual void setValue(std::string v)
    {
        _value = v;
    }
#endif
    ~XNode() {}

    private:

    std::string _value;
};

class StringNode : public XNode
{
    public:
    StringNode(char * str) : _value(str)
    {
    }

    virtual std::string value() { return _value; }
#if 0
    virtual void setValue(std::string v)
    {
        _value = v;
    }
#endif
    private:

    std::string _value;
};

inline std::ostream& operator<<(std::ostream& strm, XNode * s)
{
    strm << s->value();
    return strm;
}

inline std::ostream& operator<<(std::ostream& strm, XNode & s)
{
    strm << s.value();
    return strm;
}


#endif
